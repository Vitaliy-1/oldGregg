<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Document as Document;
use JATSParser\Body\ListItem as ListItem;

class Listing implements JATSElement {

	/*
	 * @var int
	 * type of a list: 1, 2, 3, 4 -> list, sublist, subsublist, etc.
	 * default is 1
	 */
	public $type;

	/* @var string: "unordered", "ordered" */
	public $style;

	public $content;

	public function __construct(\DOMElement $list) {
		$xpath = Document::getXpath();
		$content = array();
		$list->hasAttribute("list-type") ? $this->style = $list->getAttribute("list-type") : $this->style = "unordered";
		$this->type = self::listElementLevel($list);

		$listItemNodes = $xpath->query("list-item", $list);
		foreach ($listItemNodes as $listItemNode) {
			$listItem = array();
			$insideListItems = $xpath->query("child::node()", $listItemNode);
			foreach ($insideListItems as $insideListItem) {
				if ($insideListItem->nodeName === "p") {
					$listInsideNodes = $xpath->query("child::node()", $insideListItem);
					foreach ($listInsideNodes as $listInsideNode) {
						if ($listInsideNode->nodeName === "list") {
							$insideListing = new Listing($listInsideNode);
							$listItem[] = $insideListing;
						} else {
							$textNodes = $xpath->query("self::text()|.//text()", $listInsideNode);
							foreach ($textNodes as $textNode) {
								/* We must ensure that picking up Text Node from the current list level -> avoiding parsing nested lists */
								if (self::listElementLevel($textNode) === $this->type) {
									$jatsText = new Text($textNode);
									$listItem[] = $jatsText;
								}
							}
						}
					}
				} elseif ($insideListItem->nodeName === "list") {
					$insideList = new Listing($insideListItem);
					$listItem[] = $insideList;
				} elseif ($insideListItem->nodeType === XML_ELEMENT_NODE) {
					$insidePar = new Par($listItemNode);
					$listItem[] = $insidePar;
				}
			}
			$content[] = $listItem;
		}

		$this->content = $content;
	}

	public function getContent(): array {
		return $this->content;
	}

	/**
	 * @return int
	 */
	public function getType(): int {
		return $this->type;
	}

	/**
	 * @return string
	 */
	public function getStyle(): string {
		return $this->style;
	}

	/**
	 * @return boolean
	 */

	private function listElementLevel(\DOMNode $textNode) {
		$count = preg_match_all("/\blist\b[^-]|\blist\b$/", $textNode->getNodePath(), $mathes);
		return $count;
	}

}