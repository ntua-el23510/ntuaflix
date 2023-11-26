<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MovieAka extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['titleId', 'ordering', 'title', 'region', 'language', 'types', 'attributes', 'isOriginalTitle'];
}
