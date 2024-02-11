<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Crew.
 *
 * @OA\Schema(
 *     description="Crew model",
 *     title="Crew model",
 *     required={"tconst"},
 *     @OA\Xml(
 *         name="Crew"
 *     )
 * )
 */
class Crew extends Model
{
    use HasFactory;

    public $timestamps = false;

    /**
     * @var array
     */
    protected $fillable = ['tconst', 'directors', 'writers'];
    /**
     * @OA\Property(
     *     format="int32",
     *     description="ID",
     *     title="ID",
     * )
     *
     * @var string
     */
    private $id;
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
     *     description="directors",
     *     title="directors",
     * )
     *
     * @var string
     */
    private $directors;
    /**
     * @OA\Property(
     *     format="string",
     *     description="writers",
     *     title="writers",
     * )
     *
     * @var string
     */
    private $writers;
}
