<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Person.
 *
 * @OA\Schema(
 *     description="MovieAka model",
 *     title="MovieAka model",
 *     required={"titleId", "ordering", "title", "isOriginalTitle"},
 *     @OA\Xml(
 *         name="MovieAka"
 *     )
 * )
 */
class MovieAka extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['titleId', 'ordering', 'title', 'region', 'language', 'types', 'attributes', 'isOriginalTitle'];
    /**
     * @OA\Property(
     *     format="string",
     *     description="titleId",
     *     title="titleId",
     * )
     *
     * @var string
     */
    private $titleId;
    /**
     * @OA\Property(
     *     format="int64",
     *     description="ordering",
     *     title="ordering",
     * )
     *
     * @var integer
     */
    private $ordering;
    /**
     * @OA\Property(
     *     format="string",
     *     description="title",
     *     title="title",
     * )
     *
     * @var string
     */
    private $title;
    /**
     * @OA\Property(
     *     format="string",
     *     description="region",
     *     title="region",
     * )
     *
     * @var string
     */
    private $region;
    /**
     * @OA\Property(
     *     format="string",
     *     description="language",
     *     title="language",
     * )
     *
     * @var string
     */
    private $language;
    /**
     * @OA\Property(
     *     format="string",
     *     description="types",
     *     title="types",
     * )
     *
     * @var string
     */
    private $types;
    /**
     * @OA\Property(
     *     description="isOriginalTitle",
     *     title="isOriginalTitle",
     * )
     *
     * @var bool
     */
    private $isOriginalTitle;
}
