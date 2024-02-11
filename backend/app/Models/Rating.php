<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Rating.
 *
 * @OA\Schema(
 *     description="Rating model",
 *     title="Rating model",
 *     required={"averageRating", "numVotes"},
 *     @OA\Xml(
 *         name="Rating"
 *     )
 * )
 */
class Rating extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'averageRating', 'numVotes'];

    protected $casts = [
        'averageRating' => 'decimal:2',
    ];
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
     *     format="float",
     *     description="averageRating",
     *     title="averageRating",
     * )
     *
     * @var float
     */
    private $averageRating;
    /**
     * @OA\Property(
     *     format="int64",
     *     description="numVotes",
     *     title="numVotes",
     * )
     *
     * @var integer
     */
    private $numVotes;
}
