<?php

namespace App\View\Components;

use Illuminate\View\Component;

class Inputs extends Component
{
    public $type;
    public $value;
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public function __construct($type, $value)
    {
        //
        $this->type = $type;
        $this->value = $value;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\View\View|string
     */
    public function render()
    {
        return view('components.inputs');
    }
}
