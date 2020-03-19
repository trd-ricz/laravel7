@extends('layouts.app')

@section('content')
	<div id="app">
		<login></login>
		<home></home>
		<posts></posts>
		<chat></chat>
		<x-terrible-component class="sample" style="color:blue">Madafaka!</x-terrible-component>
		<x-inputs.text type="text" value="sample value"></x-inputs.text>
	</div>


@stop