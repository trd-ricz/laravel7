<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class LoginController extends Controller
{

    private $success = 'ng';
    private $message = '';
    private $result = null;

    //
    public function response(){
        $result = array(
            'success' => $this->success,
            'message' => $this->message,
            'result' => $this->result
        );
        return response()->json($result);
    }

    public function userLogin(){



        return $this->response();
    }
}
