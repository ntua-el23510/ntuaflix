<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Principal.
 *
 * @OA\Schema(
 *     description="Principal model",
 *     title="Principal model",
 *     required={"tconst", "nconst", "category"},
 *     @OA\Xml(
 *         name="Principal"
 *     )
 * )
 */
class Principal extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'nconst', 'category', 'job', 'characters', 'img_url_asset'];

    protected $casts = [
        'characters' => 'array',
    ];

    public function person()
    {
        return $this->belongsTo(Person::class, 'nconst');
    }

    public function movie()
    {
        return $this->belongsTo(Movie::class, 'tconst');
    }
    /**
     * @OA\Property(
     *     format="string",
     *     description="tconst",
     *     title="tconst",
     * )
     *
     * @var string
     */
    private $tconst;
    /**
     * @OA\Property(
     *     format="string",
     *     description="nconst",
     *     title="nconst",
     * )
     *
     * @var string
     */
    private $nconst;
    /**
     * @OA\Property(
     *     format="string",
     *     description="category",
     *     title="category",
     * )
     *
     * @var string
     */
    private $category;
    /**
     * @OA\Property(
     *     format="string",
     *     description="job",
     *     title="job",
     * )
     *
     * @var string
     */
    private $job;
    /**
     * @OA\Property(
     *     format="string",
     *     description="characters",
     *     title="characters",
     * )
     *
     * @var string
     */
    private $characters;
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
