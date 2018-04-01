<?php namespace JATSParser\Body;

use JATSParser\Body\Document as Document;

class Figure implements JATSElement {

	/* @var $label string */
	private $label;

	/* @var $link string */
	private $link;

	/* @var $id string */
	private $id;

	/* @var $content array; figure caption */
	private $content;

	/* @var $title array */
	private $title;

	public function __construct(\DOMElement $figureElement) {
		$xpath = Document::getXpath();

		$this->extractLabel($figureElement, $xpath);
		$this->extractId($figureElement);
		$this->extractLink($figureElement, $xpath);
		$this->extractTitle($figureElement, $xpath);
		$this->extractContent($figureElement, $xpath);
	}

	public function getContent(): array {
		return $this->content;
	}

	public function getLink(): string {
		return $this->link;
	}

	public function getId(): string {
		return $this->id;
	}

	public function getTitle(): array {
		return $this->title;
	}

	public function getLabel(): string {
		return $this->label;
	}

	private function extractLabel(\DOMElement $figureElement, \DOMXPath $xpath){
		$labelElements = $xpath->query(".//label", $figureElement);
		if ($labelElements->length > 0) {
			foreach ($labelElements as $labelElement) {
				$this->label = $labelElement->nodeValue;
			}
		}
	}

	private function extractId(\DOMElement $figureElement) {
		if ($figureElement->hasAttribute("id")) {
			$this->id = $figureElement->getAttribute("id");
		}
	}

	private function extractLink(\DOMElement $figureElement, \DOMXPath $xpath) {
		$graphicElementAttributes = $xpath->query(".//graphic[1]/@xlink:href", $figureElement);
		if ($graphicElementAttributes->length > 0) {
			foreach ($graphicElementAttributes as $link) {
				$this->link = $link->nodeValue;
			}
		}
	}

	private function extractTitle(\DOMElement $figureElement, \DOMXPath $xpath) {
		$title = array();
		$titleElements = $xpath->query(".//title[1]//text()", $figureElement);
		if ($titleElements->length > 0) {
			foreach ($titleElements as $titleElement) {
				$jatsText = new Text($titleElement);
				$title[] = $jatsText;
			}
		}
		$this->title = $title;
	}

	/* Note: we are getting figure caption here from JATS */
	private function extractContent(\DOMElement $figureElement, \DOMXPath $xpath) {
		$content = array();
		$captionNodes =  $xpath->query(".//caption[1]", $figureElement);
		if ($captionNodes->length > 0) {
			foreach ($captionNodes as $captionNode) {
				$captionPars = $xpath->query("p", $captionNode);
				foreach ($captionPars as $captionPar) {
					$par = new Par($captionPar);
					$caption[] = $par;
				}
			}
		}
		$this->content = $content;
	}
}