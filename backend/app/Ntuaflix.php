<?php

/**
 * @license Apache 2.0
 */

namespace App;

use OpenApi\Annotations as OA;

/**
 * @OA\Info(
 *     description="This is a Ntuaflix server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).",
 *     version="1.0.0",
 *     title="Swagger Ntuaflix",
 *     termsOfService="http://swagger.io/terms/",
 *     @OA\Contact(
 *         email="el23510@mail.ntua.gr"
 *     ),
 *     @OA\License(
 *         name="Apache 2.0",
 *         url="http://www.apache.org/licenses/LICENSE-2.0.html"
 *     )
 * )
 * @OA\Tag(
 *     name="Media",
 *     description="Everything about Movies",
 * )
 * @OA\Tag(
 *     name="People",
 *     description="Everything about Peoples",
 * )
 * @OA\Tag(
 *     name="Principals",
 *     description="Everything about Principals",
 * )
 * @OA\Tag(
 *     name="Auth"
 * )
 * @OA\Server(
 *      url=L5_SWAGGER_CONST_HOST,
 *      description="Ntuaflix API Server"
 * )
 */
class Ntuaflix
{
}
