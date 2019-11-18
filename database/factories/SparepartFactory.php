<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Sparepart;
use Faker\Generator as Faker;

$factory->define(Sparepart::class, function (Faker $faker) {
    $sparepartNama = array(
        'Accu B',
        'Accu AA',
        'Velg A',
        'Velg C',
        'Oli C',
        'Oli Garda C',
    );

    return [
        'nama'            => $faker->randomElement($sparepartNama),
        'jenis_kendaraan' => $faker->randomElement(array('Mobil', 'Motor')),
        'harga'           => $faker->randomNumber(3) * 1000
    ];
});
