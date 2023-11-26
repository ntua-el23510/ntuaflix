<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Crew extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'directors', 'writers'];
}
