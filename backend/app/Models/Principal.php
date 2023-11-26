<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Principal extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'nconst', 'category', 'job', 'characters', 'img_url_asset'];
}
