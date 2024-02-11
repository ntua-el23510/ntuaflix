<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

/**
 * Class Movie.
 *
 * @OA\Schema(
 *     description="Movie model",
 *     title="Movie model",
 *     required={"titleType", "primaryTitle", "originalTitle", "isAdult", "startYear"},
 *     @OA\Xml(
 *         name="Movie"
 *     )
 * )
 */
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
    /**
     * @OA\Property(
     *     format="string",
     *     description="ID",
     *     title="ID",
     * )
     *
     * @var string
     */
    private $tconst;
    /**
     * @OA\Property(
     *     format="string",
     *     description="titleType",
     *     title="titleType",
     * )
     *
     * @var string
     */
    private $titleType;
    /**
     * @OA\Property(
     *     format="string",
     *     description="primaryTitle",
     *     title="primaryTitle",
     * )
     *
     * @var string
     */
    private $primaryTitle;
    /**
     * @OA\Property(
     *     format="string",
     *     description="originalTitle",
     *     title="originalTitle",
     * )
     *
     * @var string
     */
    private $originalTitle;
    /**
     * @OA\Property(
     *     description="is adult",
     *     title="isAdult",
     * )
     *
     * @var bool
     */
    private $isAdult;
    /**
     * @OA\Property(
     *     format="int32",
     *     description="startYear",
     *     title="startYear",
     * )
     *
     * @var integer
     */
    private $startYear;
    /**
     * @OA\Property(
     *      format="int32",
     *     description="endYear",
     *     title="endYear",
     * )
     *
     * @var integer
     */
    private $endYear;
    /**
     * @OA\Property(
     * format="int32",
     *     description="runtimeMinutes",
     *     title="runtimeMinutes",
     * )
     *
     * @var integer
     */
    private $runtimeMinutes;
    /**
     * @OA\Property(
     *     format="string",
     *     description="genres",
     *     title="genres",
     * )
     *
     * @var string
     */
    private $genres;
    /**
     * @OA\Property(
     *     format="string",
     *     description="img_url_asset",
     *     title="img_url_asset",
     * )
     *
     * @var string
     */
    private $img_url_asset;
}
