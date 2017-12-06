<?php

class JatsList
{
    private $type;
    private $content;

    public function __construct() {
        $this->content = new ArrayObject(array());
    }

    /**
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param mixed $type
     */
    public function setType($type)
    {
        $this->type = $type;
    }

    public function getContent()
    {
        if ($this->content == null) {
            $this->content = new ArrayObject();
        }
        return $this->content;
    }
}