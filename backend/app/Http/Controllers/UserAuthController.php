<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class UserAuthController extends Controller
{
    public function register(Request $request)
    {
        $registerUserData = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|min:8|confirmed',
        ]);
        $user = User::create([
            'name' => $registerUserData['name'],
            'email' => $registerUserData['email'],
            'password' => Hash::make($registerUserData['password']),
        ]);

        return response()->json([
            'message' => 'User Created ',
            'data' => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        $loginUserData = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|min:8',
        ]);
        $user = User::where('email', $loginUserData['email'])->first();
        if (!$user || !Hash::check($loginUserData['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid Credentials',
            ], Response::HTTP_UNAUTHORIZED);
        }
        $token = $user->createToken($user->name . '-AuthToken')->plainTextToken;

        return response()->json([
            'token' => $token,
        ]);
    }

    public function user(Request $request)
    {
        $user = User::find(auth()->id());

        return new UserResource($user->loadMissing(['toWatchMovies', 'viewedMovies']));
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();

        return response()->json([
            'message' => 'logged out',
        ]);
    }
}
