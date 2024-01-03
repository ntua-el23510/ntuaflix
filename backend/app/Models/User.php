<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Enums\ToWatchStatusEnum;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function userMoviesList()
    {
        return $this->belongsToMany(Movie::class, 'movie_user', 'user_id', 'movie_id')->withTimestamps();
    }

    public function viewedMovies()
    {
        return $this->belongsToMany(Movie::class, 'movie_user', 'user_id', 'movie_id')->wherePivot('status', ToWatchStatusEnum::VIEWED->value)->withTimestamps();
    }

    public function toWatchMovies()
    {
        return $this->belongsToMany(Movie::class, 'movie_user', 'user_id', 'movie_id')->wherePivot('status', ToWatchStatusEnum::TOWATCH->value)->withTimestamps();
    }
}
