<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Person extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'nconst';

    /**
     * The "type" of the auto-incrementing ID.
     *
     * @var string
     */
    protected $keyType = 'string';

    /**
     * @var array
     */
    protected $fillable = ['primaryName', 'birthYear', 'deathYear', 'primaryProfession', 'knownForTitles', 'img_url_asset'];

    public function principals()
    {
        return $this->hasMany(Principal::class, 'nconst');
    }
}
