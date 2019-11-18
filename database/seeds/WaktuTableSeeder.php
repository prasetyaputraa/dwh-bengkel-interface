<?php

use Illuminate\Database\Seeder;

class WaktuTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(App\Models\Dimensions\Waktu::class, 10)->create();
    }
}
