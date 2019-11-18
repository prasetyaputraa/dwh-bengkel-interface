<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Dimensions\Waktu;
use Faker\Generator as Faker;
use Carbon\Carbon;

$factory->define(Waktu::class, function (Faker $faker) {
    $periodes = array(
        'Hari',
        'Minggu',
        'Bulan',
        'Kuartal',
        'Tahun'
    );

    $randomIndex = rand(0, sizeof($periodes) - 1);
    $randomDate  = $faker->date('Y-m-d', 'now');

    $periode = $periodes[$randomIndex];
    $date    = Carbon::createFromFormat('Y-m-d', $randomDate);

    $startEndDate = array();
    $expl         = $date->format('l');

    switch ($periode) {
        case 'Hari':
            $startEndDate = array(
                $date->copy(),
                $date->copy()
            );

            $expl = $date->format('l');
            break;
        case 'Minggu':
            $startEndDate = array(
                $date->copy()->startOfWeek(),
                $date->copy()->endOfWeek()
            );

            $expl = $date->weekOfYear;
            break;
        case 'Bulan':
            $startEndDate = array(
                $date->copy()->startOfMonth(),
                $date->copy()->endOfMonth()
            );

            $expl = $date->month;
            break;

        case 'Kuartal':
            $startEndDate = array(
                $date->copy()->firstOfQuarter(),
                $date->copy()->endOfQuarter()
            );

            $expl = $date->quarter;
            break;

        case 'Tahun':
            $startEndDate = array(
                $date->copy()->firstOfYear(),
                $date->copy()->endOfYear()
            );

            $expl = $date->year;
            break;

        default:
            break;
    }

    return [
        'mulai'      => $startEndDate[0],
        'akhir'      => $startEndDate[1],
        'periode'    => $periode,
        'keterangan' => $expl
    ];
});
