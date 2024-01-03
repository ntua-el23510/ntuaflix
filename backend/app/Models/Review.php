<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Review.
 *
 * @OA\Schema(
 *     description="Review model",
 *     title="Review model",
 *     required={"rating", "review"},
 *     @OA\Xml(
 *         name="Review"
 *     )
 * )
 */
class Review extends Model
{
    use HasFactory;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'rating', 'review'];

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
     *     format="int64",
     *     description="rating",
     *     title="rating",
     * )
     *
     * @var integer
     */
    private $rating;
    /**
     * @OA\Property(
     *     format="string",
     *     description="review",
     *     title="review",
     * )
     *
     * @var string
     */
    private $review;
}
