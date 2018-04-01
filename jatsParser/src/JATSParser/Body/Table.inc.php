<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Document as Document;
use JATSParser\Body\Row as Row;
use JATSParser\Body\Text as Text;

class Table implements JATSElement {

	/* @var $id string */
	private $id;

	/* @var $label string */
	private $label;

	/* @var $content array */
	private $content;

	/* @var $hasHead bool */
	private $hasHead;

	/* @var $hasBody bool */
	private $hasBody;

	/* @var $title array */
	private $title;

	/* @var $notes array */
	private $notes;

	public function __construct(\DOMElement $tableWraper) {
		$xpath = Document::getXpath();

		$this->extractLabel($tableWraper, $xpath);
		$this->extractId($tableWraper);
		$this->extractContent($tableWraper, $xpath);
		$this->extractTitle($tableWraper, $xpath);
		$this->extractCaption($tableWraper, $xpath);
	}

	public function getContent(): array {
		return $this->content;
	}

	public function getId(): string {
		return $this->id;
	}

	public function getLabel(): string {
		return $this->label;
	}

	public function getTitle(): array {
		return $this->title;
	}

	public function getNotes(): array {
		return $this->notes;
	}

	private function extractLabel(\DOMElement $tableWraper, \DOMXPath $xpath) {
		$labelNodes = $xpath->evaluate(".//label[1]", $tableWraper);
		foreach ($labelNodes as $labelNode) {
			$this->label = $labelNode->nodeValue;
		}
	}

	private function extractID(\DOMElement $tableWraper) {
		if ($tableWraper->hasAttribute("id")) {
			$this->id = $tableWraper->getAttribute("id");
		}
	}

	private function extractContent(\DOMElement $tableWraper, \DOMXPath $xpath) {
		$content = array();

		$tableHeadNode = $xpath->query(".//thead", $tableWraper);
		if ($tableHeadNode->length > 0) {
			$this->hasHead = TRUE;
		} else {
			$this->hasHead = FALSE;
		}

		$tableBodyNode = $xpath->query(".//tbody", $tableWraper);
		if ($tableBodyNode->length > 0) {
			$this->hasBody = TRUE;
		} else {
			$this->hasBody = FALSE;
		}

		$rowNodes = $xpath->query(".//tr", $tableWraper);
		foreach ($rowNodes as $rowNode) {
			$row = new Row($rowNode);
			$content[] = $row;
		}
		$this->content = $content;
	}

	private function extractTitle(\DOMElement $tableWraper, \DOMXPath $xpath) {
		$title = array();
		$titleNodes =  $xpath->query(".//title[1]//text()", $tableWraper);
		if ($titleNodes->length > 0) {
			foreach ($titleNodes as $textNode) {
				$jatsText = new Text($textNode);
				$title[] = $jatsText;
			}
		}
		$this->title = $title;
	}

	private function extractCaption(\DOMElement $tableWraper, \DOMXPath $xpath) {
		$caption = array();
		$captionNodes =  $xpath->query(".//caption[1]", $tableWraper);
		if ($captionNodes->length > 0) {
			foreach ($captionNodes as $captionNode) {
				$captionPars = $xpath->query("p", $captionNode);
				foreach ($captionPars as $captionPar) {
					$par = new Par($captionPar);
					$caption[] = $par;
				}
			}
		}
		$this->notes = $caption;
	}
}