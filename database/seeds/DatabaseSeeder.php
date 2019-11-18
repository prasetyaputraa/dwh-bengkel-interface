<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(SupplierTableSeeder::class);
        $this->call(PelangganTableSeeder::class);
        $this->call(PegawaiTableSeeder::class);
        $this->call(JasaTableSeeder::class);
        $this->call(SparepartTableSeeder::class);
        $this->call(WaktuTableSeeder::class);
    }
}
