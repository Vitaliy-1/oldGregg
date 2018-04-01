<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Text as Text;
use JATSParser\Body\Par as Par;

class Cell implements JATSElement {

	/* @var array Can contain Par and Text */
	private $content = array();

	/* @var $type string  */
	private $type;

	/* @var $colspan int  */
	private $colspan;

	/* @var $rowspan int  */
	private $rowspan;

	function __construct(\DOMElement $cellNode) {
		$this->type = $cellNode->nodeName;

		$content = array();
		$xpath = Document::getXpath();
		$childNodes = $xpath->query("child::node()", $cellNode);
		foreach ($childNodes as $childNode) {
			if ($childNode->nodeName === "p") {
				$par = new Par($childNode);
				$content[] = $par;
			} else {
				$jatsTextNodes = $xpath->query(".//self::text()", $childNode);
				foreach ($jatsTextNodes as $jatsTextNode){
					$jatsText = new Text($jatsTextNode);
					$content[] = $jatsText;
				}
			}
		}

		$this->content = $content;

		$cellNode->hasAttribute("colspan") ? $this->colspan = $cellNode->getAttribute("colspan") : $this->colspan = 1;

		$cellNode->hasAttribute("rowspan") ? $this->rowspan = $cellNode->getAttribute("rowspan") : $this->rowspan = 1;

	}

	/**
	 * @return array
	 */

	public function getContent(): array {
		return $this->content;
	}

	/**
	 * @return string
	 */

	public function getType(): string {
		return $this->type;
	}

	/**
	 * @return int
	 */
	public function getColspan(): int
	{
		return $this->colspan;
	}

	/**
	 * @return int
	 */
	public function getRowspan(): int
	{
		return $this->rowspan;
	}
}
