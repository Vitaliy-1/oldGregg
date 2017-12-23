<?php

/**
 * @file plugins.generic.jatsParser.lib.main.Back
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Body
 * @ingroup plugins_generic_jatsParser
 *
 * @brief For parsing a main sections (in the body node) of JATS XML. Supported up to 3 level deep (sections, subsections and subsubsections)
 */

import("plugins.generic.jatsParser.lib.classes.ArticleSection");
import("plugins.generic.jatsParser.lib.classes.ParContent");
import("plugins.generic.jatsParser.lib.classes.ParText");
import("plugins.generic.jatsParser.lib.classes.Xref");
import("plugins.generic.jatsParser.lib.classes.Italic");
import("plugins.generic.jatsParser.lib.classes.Sup");
import("plugins.generic.jatsParser.lib.classes.Sub");
import("plugins.generic.jatsParser.lib.classes.XrefFig");
import("plugins.generic.jatsParser.lib.classes.XrefTable");
import("plugins.generic.jatsParser.lib.classes.XrefVideo");
import("plugins.generic.jatsParser.lib.classes.Bold");
import("plugins.generic.jatsParser.lib.classes.Table");
import("plugins.generic.jatsParser.lib.classes.Row");
import("plugins.generic.jatsParser.lib.classes.Cell");
import("plugins.generic.jatsParser.lib.classes.Figure");
import("plugins.generic.jatsParser.lib.classes.JatsList");
import("plugins.generic.jatsParser.lib.classes.Video");

class Body
{

    function bodyParsing (DOMXPath $xpath)
        /* for parasing sections, subsections, subsubsections */
    {
        $sections = new ArrayObject();
        foreach ($xpath->evaluate("/article/body/sec") as $sec) {
            $section = new ArticleSection();
            $subSecNodes = $xpath->query("sec", $sec);
            if ($subSecNodes->length === 0) {
                $section->setHasSection(false);
            } else {
                $section->setHasSection(true);
            }
            $sections->append($section);
            self::sectionParsing($xpath, $sec, $section);
            foreach ($xpath->evaluate("sec", $sec) as $subsec) {
                $subSection = new ArticleSection();
                $section->getContent()->append($subSection);
                self::sectionParsing($xpath, $subsec, $subSection);
                foreach ($xpath->evaluate("sec", $subsec) as $subsubsec) {
                    $subSubSection = new ArticleSection();
                    $subSection->getContent()->append($subSubSection);
                    self::sectionParsing($xpath, $subsubsec, $subSubSection);
                }
            }
        }
        return $sections;
    }

    /**
     * @param $xpath
     * @param $sec -> our section DOM Node
     * @param $sections -> our section as ArrayObject
     */
    function sectionParsing(DOMXPath $xpath, DOMElement $sec, ArticleSection $section)
    {
        foreach ($xpath->evaluate("title|p|fig|sec|table-wrap|list|media", $sec) as $secContent) {

            if ($secContent->tagName == "title") {
                $section->setTitle(trim($secContent->nodeValue));
            } elseif ($secContent->tagName == "list") { // start of parsing lists, ordered and unordered are supported
                $listContent = new JatsList();
                $section->getContent()->offsetSet(null, $listContent);
                $this->listParsing($xpath, $secContent, $listContent);

            } elseif ($secContent->tagName == "p") { // start of parsing paragraphs
                $paragraphContent = new ParContent();
                $paragraphContent->setType("paragraph");
                $section->getContent()->offsetSet(null, $paragraphContent);
                self::paragraphParsing($secContent, $paragraphContent);

            } elseif ($secContent->tagName == "table-wrap") { // start of parsing tables
                $table = new Table();
                $section->getContent()->offsetSet(null, $table);
                $tableIdAttr = $secContent->getAttribute("id");
                if ($tableIdAttr != null) {
                    $table->setId($tableIdAttr);
                }

                /* set table label, e.g. 'Table 1' */
                foreach ($xpath->evaluate("label", $secContent) as $labelNode) {
                    $table->setLabel($labelNode->nodeValue);
                }

                /* parsing table title */
                foreach ($xpath->evaluate("caption/title", $secContent) as $tableTitle) {
                    $titleParagraph = new ParContent();
                    $titleParagraph->setType("table-title");
                    $table->getContent()->offsetSet(null, $titleParagraph);
                    self::paragraphParsing($tableTitle, $titleParagraph);
                }

                /* parsing table with head and body */
                foreach ($xpath->evaluate("table/thead/tr|table/tbody/tr", $secContent) as $rowNode) {
                    if ($rowNode != null) {
                        $row = new Row();
                        $parentNode = $rowNode->parentNode;
                        if ($parentNode->tagName == "thead") {
                            $row->setType("head");
                            $table->getContent()->offsetSet(null, $row);
                            foreach ($xpath->evaluate("th|td", $rowNode) as $cellNode) {
                                $cell = new Cell();
                                $row->getContent()->offsetSet(null, $cell);
                                $cell->setColspan($cellNode->getAttribute("colspan"));
                                $cell->setRowspan($cellNode->getAttribute("rowspan"));
                                self::paragraphParsing($cellNode, $cell);
                            }
                        } elseif ($parentNode->tagName == "tbody") {
                            $row->setType("body");
                            $table->getContent()->offsetSet(null, $row);
                            foreach ($xpath->evaluate("th|td", $rowNode) as $cellNode) {
                                $cell = new Cell();
                                $row->getContent()->offsetSet(null, $cell);
                                $cell->setColspan($cellNode->getAttribute("colspan"));
                                $cell->setRowspan($cellNode->getAttribute("rowspan"));
                                self::paragraphParsing($cellNode, $cell);
                            }
                        }
                    }
                }

                /* parsing table without head */
                foreach ($xpath->evaluate("table/tr", $secContent) as $rowNodeWithoutHead) {
                    if ($rowNodeWithoutHead != null) {
                        $row = new Row();
                        $row->setType("flat");
                        $table->getContent()->offsetSet(null, $row);
                        foreach ($xpath->evaluate("th|td", $rowNodeWithoutHead) as $cellNodeWithoutHead) {
                            $cell = new Cell();
                            $row->getContent()->offsetSet(null, $cell);
                            $cell->setColspan($cellNodeWithoutHead->getAttribute("colspan"));
                            $cell->setRowspan($cellNodeWithoutHead->getAttribute("rowspan"));
                            self::paragraphParsing($cellNodeWithoutHead, $cell);
                        }

                    }
                }

                /* parsing table caption */
                foreach ($xpath->evaluate("caption/p", $secContent) as $tableCaption) {
                    $captionParagraph = new ParContent();
                    $captionParagraph->setType("table-caption");
                    $table->getContent()->offsetSet(null, $captionParagraph);
                    self::paragraphParsing($tableCaption, $captionParagraph);
                }


            } elseif ($secContent->tagName == "fig") {
                $figure = new Figure();
                $section->getContent()->offsetSet(null, $figure);
                $figure->setId($secContent->getAttribute("id"));
                foreach ($xpath->evaluate("label", $secContent) as $labelNode) {
                    $figure->setLabel($labelNode->nodeValue);
                }
                foreach ($xpath->evaluate("caption/title", $secContent) as $figureTitleNode) {
                    $figureTitle = new ParContent();
                    $figureTitle->setType("figure-title");
                    $figure->getContent()->offsetSet(null, $figureTitle);
                    self::paragraphParsing($figureTitleNode, $figureTitle);
                }
                foreach ($xpath->evaluate("caption/p", $secContent) as $figureCaptionNode) {
                    $figureCaption = new ParContent();
                    $figureCaption->setType("figure-caption");
                    $figure->getContent()->offsetSet(null, $figureCaption);
                    self::paragraphParsing($figureCaptionNode, $figureCaption);
                }
                foreach ($xpath->evaluate("graphic", $secContent) as $graphicLinksNode) {
                    $figure->setLink($graphicLinksNode->getAttribute("xlink:href"));
                }

            } elseif ($secContent->tagName == "media") {
                $video = new Video();
                $section->getContent()->offsetSet(null, $video);
                $video->setId($secContent->getAttribute("id"));
                $video->setLink($secContent->getAttribute("xlink:href"));
                foreach ($xpath->evaluate("label", $secContent) as $labelNode) {
                    $video->setLabel($labelNode->nodeValue);
                }
                foreach ($xpath->evaluate("caption/title", $secContent) as $videoTitleNode) {
                    $videoTitle = new ParContent();
                    $videoTitle->setType("video-title");
                    $video->getTitle()->offsetSet(null, $videoTitle);
                    self::paragraphParsing($videoTitleNode, $videoTitle);
                }
                foreach ($xpath->evaluate("caption/p", $secContent) as $videoCaptionNode) {
                    $videoCaption = new ParContent();
                    $videoCaption->setType("video-caption");
                    $video->getContent()->offsetSet(null, $videoCaption);
                    self::paragraphParsing($videoCaptionNode, $videoCaption);
                }

            }
        }
    }

    /**
     * @param $secContent -> XML section Node content
     * @param $paragraphContent -> Cell or ParContent object
     */
    function paragraphParsing(DOMElement $secContent, $paragraphContent) {
        foreach ($secContent->childNodes as $parContent) {
            if ($parContent->nodeType == XML_TEXT_NODE) {
                $parText = new ParText();
                $parText->setContent($parContent->nodeValue);
                $paragraphContent->getContent()->offsetSet(null, $parText);
            } elseif ($parContent->tagName == "xref") {
                if ($parContent->getAttribute("ref-type") == "bibr") {
                    $ref = new Xref();
                    $ref->setRid($parContent->getAttribute("rid"));
                    $ref->setContent($parContent->nodeValue);
                    $paragraphContent->getContent()->offsetSet(null, $ref);
                } elseif ($parContent->getAttribute("ref-type") == "table") {
                    $ref = new XrefTable();
                    $ref->setRid($parContent->getAttribute("rid"));
                    $ref->setContent($parContent->nodeValue);
                    $paragraphContent->getContent()->offsetSet(null, $ref);
                } elseif ($parContent->getAttribute("ref-type") == "fig") {
                    $ref = new XrefFig();
                    $ref->setRid($parContent->getAttribute("rid"));
                    $ref->setContent($parContent->nodeValue);
                    $paragraphContent->getContent()->offsetSet(null, $ref);
                } elseif ($parContent->getAttribute("ref-type") == "other") {
                    $ref = new XrefVideo();
                    $ref->setRid($parContent->getAttribute("rid"));
                    $ref->setContent($parContent->nodeValue);
                    $paragraphContent->getContent()->offsetSet(null, $ref);
                }
            } elseif ($parContent->tagName == "italic") {
                $italic = new Italic();
                $paragraphContent->getContent()->offsetSet(null, $italic);
                self::paragraphParsing($parContent, $italic);
            } elseif ($parContent->tagName == "bold") {
                $bold = new Bold();
                $paragraphContent->getContent()->offsetSet(null, $bold);
                self::paragraphParsing($parContent, $bold);
            } elseif ($parContent->tagName == "sup") {
                $sup = new Sup();
                $sup->setContent($parContent->nodeValue);
                $paragraphContent->getContent()->offsetSet(null, $sup);
            } elseif ($parContent->tagName == "sub") {
                $sub = new Sub();
                $sub->setContent($parContent->nodeValue);
                $paragraphContent->getContent()->offsetSet(null, $sub);
            } elseif ($parContent->tagName == "p") {
                $paraContent = new ParContent();
                $paragraphContent->getContent()->offsetSet(null, $paraContent);
                self:$this->paragraphParsing($parContent, $paraContent);
            }
        }
    }

    /**
     * @param DOMXPath $xpath
     * @param DOMElement $secContent
     * @param $listContent
     */
    public function listParsing(DOMXPath $xpath, DOMElement $secContent, JatsList $listContent)
    {
        if ($secContent->getAttribute("list-type") == "ordered" || $secContent->getAttribute("list-type") == "order" || $secContent->getAttribute("list-type") == "roman-lower") {
            $listContent->setType("list-ordered");
        } elseif ($secContent->getAttribute("list-type") == null || $secContent->getAttribute("list-type") == "unordered" || $secContent->getAttribute("list-type") == "bullet" || $secContent->getAttribute("list-type") == "simple") {
            $listContent->setType("list-unordered");
        }
        foreach ($xpath->evaluate("list-item/p", $secContent) as $listItem) {
            $listParagraphContent = new ParContent();
            $listContent->getContent()->offsetSet(null, $listParagraphContent);
            self::paragraphParsing($listItem, $listParagraphContent);

            foreach ($xpath->evaluate("../list", $listItem) as $sublistItem) {
                $subListContent = new JatsList();
                $listParagraphContent->getContent()->offsetSet(null, $subListContent);
                $this->listParsing($xpath, $sublistItem, $subListContent);
            }
        }
    }
}
