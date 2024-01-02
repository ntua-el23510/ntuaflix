<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Movie extends Model
{
    use HasFactory;
    public $timestamps = false;
    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'tconst';
    /**
     * The "type" of the auto-incrementing ID.
     *
     * @var string
     */
    protected $keyType = 'string';

    /**
     * @var array
     */
    protected $fillable = ['titleType', 'primaryTitle', 'originalTitle', 'isAdult', 'startYear', 'endYear', 'runtimeMinutes', 'genres', 'img_url_asset'];

    public function rating(): HasOne
    {
        return $this->hasOne(Rating::class, 'tconst');
    }

    public function principals(): HasMany
    {
        return $this->hasMany(Principal::class, 'tconst');
    }

    public function alternativeTitles(): HasMany
    {
        return $this->hasMany(MovieAka::class, 'titleId');
    }

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class, 'tconst');
    }
}
