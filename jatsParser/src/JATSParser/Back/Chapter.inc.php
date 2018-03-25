<?php namespace JATSParser\Back;

use JATSParser\Back\AbstractReference as AbstractReference;

class Chapter extends AbstractReference
{

	/* @var $title string */
	private $title;

	/* @var $book string */
	private $book;

	/* @var $publisherLoc string */
	private $publisherLoc;

	/* @var $publisherName string */
	private $publisherName;

	/* @var $fpage string */
	private $fpage;

	/* @var $lpage string */
	private $lpage;

	public function __construct(\DOMElement $reference)
	{

		parent::__construct($reference);

		$this->title = $this->extractFromElement($reference, ".//chapter-title[1]");
		$this->book = $this->extractFromElement($reference, ".//source[1]");
		$this->publisherLoc = $this->extractFromElement($reference, ".//publisher-loc[1]");
		$this->publisherName = $this->extractFromElement($reference, ".//publisher-name[1]");
		$this->fpage = $this->extractFromElement($reference, './/fpage[1]');
		$this->lpage = $this->extractFromElement($reference, './/lpage[1]');
	}

	/**
	 * @return string
	 */
	public function getId(): string
	{
		return $this->id;
	}

	/**
	 * @return string
	 */
	public function getTitle(): string
	{
		return $this->title;
	}

	/**
	 * @return array
	 */
	public function getAuthors(): array
	{
		return $this->authors;
	}

	/**
	 * @return array
	 */
	public function getEditors(): array
	{
		return $this->editors;
	}

	/**
	 * @return string
	 */
	public function getYear(): string
	{
		return $this->year;
	}

	/**
	 * @return string
	 */
	public function getUrl(): string
	{
		return $this->url;
	}

	/**
	 * @return string
	 */
	public function getFpage(): string
	{
		return $this->fpage;
	}

	/**
	 * @return string
	 */
	public function getLpage(): string
	{
		return $this->lpage;
	}

	/**
	 * @return array
	 */
	public function getPubIdType(): array
	{
		return $this->pubIdType;
	}

	/**
	 * @return string
	 */
	public function getBook(): string
	{
		return $this->book;
	}

	/**
	 * @return string
	 */
	public function getPublisherName(): string
	{
		return $this->publisherName;
	}

	/**
	 * @return string
	 */
	public function getPublisherLoc(): string
	{
		return $this->publisherLoc;
	}
}