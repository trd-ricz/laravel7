@extends('layouts.app')

@section('content')
	@php

	$value = [
		[
			"row_id" => 1,
			"content" => "LoremIpsum",
			"author" => "Ricsheil",
			"date" => "today"
		],
		[
			"row_id" => 2,
			"content" => "Wolly",
			"author" => "Ricsheil",
			"date" => "today"
		],
		[
			"row_id" => 3,
			"content" => "Eva",
			"author" => "Ricsheil",
			"date" => "today"
		],
		[
			"row_id" => 4,
			"content" => "Hello darkness",
			"author" => "Ricsheil",
			"date" => "today"
		]
	];
	$default_post = json_encode($value);

	@endphp
	<div id="app">
		<home></home>
		<posts :default-posts="{{$default_post}}"></posts>
	</div>


@stop