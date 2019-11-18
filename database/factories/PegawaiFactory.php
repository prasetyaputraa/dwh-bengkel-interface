<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Pegawai;
use Faker\Generator as Faker;

$factory->define(Pegawai::class, function (Faker $faker) {
    return [
        'nama'       => $faker->unique()->name,
        'no_telepon' => $faker->unique()->phoneNumber,
        'alamat'     => $faker->unique()->streetAddress,
        'jabatan'    => $faker->randomElement(array('Mekanik', 'Operator'))
    ];
});
