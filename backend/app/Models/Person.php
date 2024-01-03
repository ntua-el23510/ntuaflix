<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Person.
 *
 * @OA\Schema(
 *     description="Person model",
 *     title="Person model",
 *     required={"primaryName", "primaryProfession", "knownForTitles", "img_url_asset"},
 *     @OA\Xml(
 *         name="Person"
 *     )
 * )
 */
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

    /**
     * @OA\Property(
     *     format="string",
     *     description="ID",
     *     title="ID",
     * )
     *
     * @var string
     */
    private $nconst;

    /**
     * @OA\Property(
     *     title="primaryName",
     * )
     *
     * @var string
     */
    private $primaryName;

    /**
     * @OA\Property(
     *     title="birthYear",
     * )
     *
     * @var int
     */
    private $birthYear;

    /**
     * @OA\Property(
     *     title="deathYear",
     * )
     *
     * @var int
     */
    private $deathYear;

    /**
     * @OA\Property(
     *     title="primaryProfession",
     * )
     *
     * @var int
     */
    private $primaryProfession;

    /**
     * @OA\Property(
     *     title="knownForTitles",
     * )
     *
     * @var int
     */
    private $knownForTitles;

    /**
     * @OA\Property(
     *     title="img_url_asset",
     * )
     *
     * @var int
     */
    private $img_url_asset;
}
