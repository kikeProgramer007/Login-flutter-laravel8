<?php

namespace App\Http\Controllers;

use App\Models\User;//LIBRERIA Q SE USA PARA CREAR USUARIO
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;//LIBRERIA DE DESINCREPTACION
use Illuminate\Support\Facades\Validator;  //LIBRERIA Q SE USA EL VALIDATOR

class AuthController extends Controller
{
    //
    public function register(Request $req){

        //VALIDATION
        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|unique:users',
            'password' => 'required|string|min:6'
        ];
        $validator = Validator::make($req->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        //CREATE NEW USER IN USERS TABLE
        $user = User::create([
            'name' => $req->name,
            'email' => $req->email,
            'password' => Hash::make($req->password)
        ]);

        $token = $user->createToken('Personal Access Token')->plainTextToken;
        $response = ['user' => $user, 'token' =>$token];

        return response()->json($response, 200);
    }

    public function login(Request $req){

        //VALIDACION DE LOGIN
        $rules = [
            'email' => 'required',
            'password' => 'required|string'
        ];

        $req->validate($rules);

        //FIND USER EMAIL IN USER TABLE
        $user = User::where('email', $req->email)->first();

        //IF USER EMAIL FOUND AND PASSWORD IS CORRECT
        if ($user && Hash::check($req->password, $user->password)) {

            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response= ['user'=> $user, 'token' => $token];
           
            return response()->json($response, 200);
        }

        $response = ['message' => 'Incorrect email or password'];
        return response()->json($response, 400);

    }

}
