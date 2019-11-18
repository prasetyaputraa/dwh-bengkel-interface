<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Pelanggan;
use Faker\Generator as Faker;

$factory->define(Pelanggan::class, function (Faker $faker) {
    return [
        'nama'       => $faker->unique()->name,
        'no_telepon' => $faker->unique()->phoneNumber,
        'alamat'     => $faker->unique()->streetAddress,
        'kota'       => $faker->city
    ];
});
