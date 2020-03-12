<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Events\ChatEvent;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('/chat', function (Request $request) {
    if ($request->user()->tokenCan('access:api')) {
        broadcast(new ChatEvent([
            "message" => $request->message,
            "author" => $request->author
        ]));
    }
})->middleware('auth:airlock');

Route::middleware('auth:airlock')->get('/user', function (Request $request) {
    if ($request->user()->tokenCan('auth:user')) {
        return
        [
            "value" => $request->user(),
            "message" => "Success",
            "status" => true
        ];
    }
    return
    [
        "value" => "",
        "message" => "no previledge!",
        "status" => false
    ];

});

Route::post('/airlock/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required'
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }
    return
    [
        "value" => $user->createToken($request->device_name,['auth:user'])->plainTextToken,
        "message" => "Success",
        "status" => true
    ];
});

Route::get('/generate_api_token', function (Request $request) {
    //
    if ($request->user()->tokenCan('auth:user')) {

        return
        [
            "value" => $request->user()->createToken('api_token', ['access:api'])->plainTextToken,
            "message" => "Success",
            "status" => true
        ];
    }
})->middleware('auth:airlock');

Route::get('/get_api', function (Request $request) {
//
    if (!$request->user()->tokenCan('access:api')) {
        return
        [
            "value" => "",
            "message" => "no preveledge!",
            "status" => false
        ];
    }
    switch($request->user()->level) {
        case 1 :
            $value = [
                [
                    "row_id" => 1,
                    "content" => "LoremIpsum",
                    "author" => "Ricsheil",
                    "date" => "today",
                    "post_level" => 1
                ],
                [
                    "row_id" => 2,
                    "content" => "Wolly",
                    "author" => "Ricsheil",
                    "date" => "today",
                    "post_level" => 1
                ],
                [
                    "row_id" => 3,
                    "content" => "Eva",
                    "author" => "Ricsheil",
                    "date" => "today",
                    "post_level" => 1
                ],
                [
                    "row_id" => 4,
                    "content" => "Hello darkness",
                    "author" => "Ricsheil",
                    "date" => "today",
                    "post_level" => 1
                ]
            ];
        break;
        case 2 :
            $value = [
                [
                    "row_id" => 1,
                    "content" => "LoremIpsum sit amit",
                    "author" => "Ricsheil level 2",
                    "date" => "today",
                    "post_level" => 2
                ],
                [
                    "row_id" => 2,
                    "content" => "Wolly level2",
                    "author" => "Ricsheil level 2",
                    "date" => "today",
                    "post_level" => 2
                ],
                [
                    "row_id" => 4,
                    "content" => "Hello darkness level2",
                    "author" => "Ricsheil level 2",
                    "date" => "today",
                    "post_level" => 2
                ]
            ];
        break;
        case 3 :
            $value = [
                [
                    "row_id" => 1,
                    "content" => "LoremIpsum sit amit",
                    "author" => "Ricsheil level 3",
                    "date" => "today",
                    "post_level" => 3
                ]
            ];
            break;
        default :

        break;
    }
    return
    [
        "value" => $value,
        "message" => "Success",
        "status" => true
    ];

})->middleware('auth:airlock');

