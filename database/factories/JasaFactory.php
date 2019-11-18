<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Jasa;
use Faker\Generator as Faker;


$factory->define(Jasa::class, function (Faker $faker) {
    $jasaNama = array(
        'Service Komplit',
        'Ganti Oli',
        'Ganti Kampas Rem',
        'Ganti Kaki-kaki'
    );

    return [
        'nama'            => $faker->randomElement($jasaNama),
        'jenis_kendaraan' => $faker->randomElement(array('Mobil', 'Motor')),
        'harga'           => $faker->randomNumber(3) * 1000
    ];
});
