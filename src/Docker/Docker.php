<?php

namespace DockerTools\Docker;

class Docker
{
    protected $bin;

    public function __construct()
    {
        $this->bin = exec('which docker');
        if (preg_match("/not found^/", $this->bin)) {
            throw new \Exception("Docker seems to not be installed !");
        }
    }
}

