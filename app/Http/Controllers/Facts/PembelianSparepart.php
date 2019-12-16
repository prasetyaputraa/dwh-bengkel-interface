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

use App\Models\Facts\SparepartPembelian;
use App\Models\Facts\SparepartPembelianBulanan;

use App\Models\ExtractionHistory;

trait PembelianSparepart
{
    public function loadSparepartPembelianAll() {
        $results = DB::connection('mysql-transaction')
            ->table('sparepart_buys')
            ->join('sparepart_buy_transactions', 'sparepart_buys.sparepart_buy_transaction_id', '=', 'sparepart_buy_transactions.id')
            ->select(
                DB::raw('sparepart_buys.sparepart_id as id_sparepart'),
                DB::raw('sparepart_buy_transactions.operator_id as id_operator'),
                DB::raw('sparepart_buy_transactions.supplier_id as id_supplier'),
                DB::raw('sparepart_buy_transactions.date as tanggal'),
                DB::raw('sparepart_buys.qty as jumlah'),
                DB::raw('sparepart_buys.total as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return (array) $result; })->toArray();

        $modelSpPembelian = new SparepartPembelian();

        $modelSpPembelian->insert($results);

        return true;
    }

    public function loadSparepartPembelianAllMonthly() {
        $modelSpPembelian        = new SparepartPembelian();
        $modelSpPembelianBulanan = new SparepartPembelianBulanan();

        $results = $modelSpPembelian
            ->groupBy('id_supplier', 'id_operator', 'id_sparepart', 'bulan', 'tahun')
            ->select(
                'id_supplier',
                'id_operator',
                'id_sparepart',
                DB::raw('MONTHNAME(tanggal) as bulan'),
                DB::raw('YEAR(tanggal) as tahun'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return $result->getAttributes(); })->toArray();

        $modelSpPembelianBulanan->insert($results);

        return true;
    }
}
