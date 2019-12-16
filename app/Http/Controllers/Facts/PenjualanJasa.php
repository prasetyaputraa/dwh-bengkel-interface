<?php

namespace App\Http\Controllers\Facts;

use DB;

use App\Models\Transactions\Customer;
use App\Models\Transactions\Employee;
use App\Models\Transactions\Service;
use App\Models\Transactions\Sparepart;
use App\Models\Transactions\Supplier;
use App\Models\Transactions\Transaction;

use App\Models\Dimensions\Jasa as DimensionService;
use App\Models\Dimensions\Pegawai as DimensionEmployee;
use App\Models\Dimensions\Pelanggan as DimensionCustomer;
use App\Models\Dimensions\Sparepart as DimensionSparepart;
use App\Models\Dimensions\Supplier as DimensionSupplier;

use App\Models\Facts\Jasa;
use App\Models\Facts\JasaBulanan;

use App\Models\ExtractionHistory;

trait PenjualanJasa
{
    public function loadJasaPenjualanAll() {
        $results = DB::connection('mysql-transaction')
            ->table('service_transactions')
            ->join('transactions', 'service_transactions.transaction_id', '=', 'transactions.id')
            ->select(
                DB::raw('transactions.customer_id as id_pelanggan'),
                DB::raw('transactions.mechanical_id as id_mekanik'),
                DB::raw('transactions.operator_id as id_operator'),
                DB::raw('service_transactions.service_id as id_jasa'),
                DB::raw('transactions.date as tanggal'),
                DB::raw('service_transactions.sub_price as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return (array) $result; })->toArray();

        $modelJasaPenjualan = new Jasa();

        $modelJasaPenjualan->insert($results);

        return true;
    }

    public function loadJasaPenjualanAllMonthly() {
        $modelJasaPenjualan        = new Jasa();
        $modelJasaPenjualanBulanan = new JasaBulanan();

        $results = $modelJasaPenjualan
            ->groupBy('id_mekanik', 'id_operator', 'id_pelanggan', 'id_jasa', 'bulan', 'tahun')
            ->select(
                'id_mekanik',
                'id_operator',
                'id_pelanggan',
                'id_jasa',
                DB::raw('MONTHNAME(tanggal) as bulan'),
                DB::raw('YEAR(tanggal) as tahun'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return $result->getAttributes(); })->toArray();

        $modelJasaPenjualanBulanan->insert($results);

        return true;
    }
}
