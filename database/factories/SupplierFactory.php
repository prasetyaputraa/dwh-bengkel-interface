<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Supplier;
use Faker\Generator as Faker;

$factory->define(Supplier::class, function (Faker $faker) {
    return [
        'nama'       => $faker->unique()->company,
        'no_telepon' => $faker->unique()->phoneNumber,
        'alamat'     => $faker->unique()->address
    ];
});
