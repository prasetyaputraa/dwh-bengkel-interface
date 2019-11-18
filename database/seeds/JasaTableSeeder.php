<?php

use Illuminate\Database\Seeder;

class JasaTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(App\Models\Dimensions\Jasa::class, 5)->create();
    }
}
