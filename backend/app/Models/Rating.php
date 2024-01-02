<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rating extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'averageRating', 'numVotes'];

    protected $casts = [
        'averageRating' => 'decimal:2'
    ];
}
