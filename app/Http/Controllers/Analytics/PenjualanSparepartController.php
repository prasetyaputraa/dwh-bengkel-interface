<?php

namespace App\Http\Controllers\Analytics;

use DB;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Facts\SparepartPenjualan;

class PenjualanSparepartController extends Controller
{
    private $modelSpPenjualan;

    public function __construct() {
        $this->modelSpPenjualan = new SparepartPenjualan();
    }

    public function byItemInYear($year) {
        $results = DB::table('fact_penjualan_sparepart_bulanan as fact')
            ->groupBy('id_sparepart')
            ->where('fact.tahun', '=', $year)
            ->join('dim_sparepart', 'fact.id_sparepart', '=', 'dim_sparepart.id')
            ->select(
                DB::raw('dim_sparepart.nama as nama'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        dd($results->toArray());
    }

    //month by month
    public function byItemInYearMonthly($year) {
        $results = DB::table('fact_penjualan_sparepart_bulanan as fact')
            ->groupBy('id_sparepart', 'bulan')
            ->where('fact.tahun', '=', $year)
            ->join('dim_sparepart', 'fact.id_sparepart', '=', 'dim_sparepart.id')
            ->select(
                DB::raw('dim_sparepart.nama as nama'),
                DB::raw('fact.bulan as bulan'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        dd($results->toArray());
    }

    //speciific month
    public function byItemInYearInMonth($year, $month) {
        $results = DB::table('fact_penjualan_sparepart_bulanan as fact')
            ->groupBy('id_sparepart')
            ->where('fact.tahun', '=', $year)
            ->where('fact.bulan', '=', $month)
            ->join('dim_sparepart', 'fact.id_sparepart', '=', 'dim_sparepart.id')
            ->select(
                DB::raw('dim_sparepart.nama as nama'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        dd($results->toArray());
    }
}
