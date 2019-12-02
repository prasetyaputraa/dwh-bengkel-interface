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

use App\Models\Facts\SparepartPenjualan;
use App\Models\Facts\SparepartPenjualanBulanan;

use App\Models\ExtractionHistory;

trait PenjualanSparepart
{
    public function loadAll() {
        $results = DB::connection('mysql-transaction')
            ->table('sparepart_transactions')
            ->join('transactions', 'sparepart_transactions.transaction_id', '=', 'transactions.id')
            ->select(
                DB::raw('transactions.customer_id as id_pelanggan'),
                DB::raw('transactions.mechanical_id as id_mekanik'),
                DB::raw('transactions.operator_id as id_operator'),
                DB::raw('sparepart_transactions.sparepart_id as id_sparepart'),
                DB::raw('transactions.date as tanggal'),
                DB::raw('sparepart_transactions.qty as jumlah'),
                DB::raw('sparepart_transactions.sub_price as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return (array) $result; })->toArray();

        $modelSpPenjualan = new SparepartPenjualan();

        $modelSpPenjualan->insert($results);

        return true;
    }

    public function getNewTransactionsSparepart() {
        $modelExtractHist = new ExtractionHistory();

        $lastExtractDate = $modelExtractHist->where('extraction_type', '=', 'Facts')
            ->latest()->first()->created_at
            ->toDateTimeString();

        $results = DB::connection('mysql-transaction')
            ->table('sparepart_transactions')
            ->where('transactions.date', '>=', $lastExtractDate)
            ->join('transactions', 'sparepart_transactions.transaction_id', '=', 'transactions.id')
            ->select(
                DB::raw('transactions.customer_id as id_pelanggan'),
                DB::raw('transactions.mechanical_id as id_mekanik'),
                DB::raw('transactions.operator_id as id_operator'),
                DB::raw('sparepart_transactions.sparepart_id as id_sparepart'),
                DB::raw('transactions.date as tanggal'),
                DB::raw('sparepart_transactions.qty as jumlah'),
                DB::raw('sparepart_transactions.sub_price as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return (array) $result; })->toArray();

        if (empty($results)) {
            return false;
        }

        $modelSpPenjualan = new SparepartPenjualan();

        $modelSpPenjualan->insert($results);

        return true;
    }

    public function loadAllMonthly() {
        $modelSpPenjualan        = new SparepartPenjualan();
        $modelSpPenjualanBulanan = new SparepartPenjualanBulanan();

        $results = $modelSpPenjualan
            ->groupBy('id_mekanik', 'id_operator', 'id_pelanggan', 'id_sparepart', 'bulan', 'tahun')
            ->select(
                'id_mekanik',
                'id_operator',
                'id_pelanggan',
                'id_sparepart',
                DB::raw('MONTHNAME(tanggal) as bulan'),
                DB::raw('YEAR(tanggal) as tahun'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return $result->getAttributes(); })->toArray();

        $modelSpPenjualanBulanan->insert($results);

        return true;
    }

    public function getNewTransactionsSparepartMonthly() {
        $modelExtractHist = new ExtractionHistory();

        $lastExtractDate = $modelExtractHist->where('extraction_type', '=', 'Facts')
            ->latest()->first()->created_at
            ->toDateTimeString();

        $modelSpPenjualan        = new SparepartPenjualan();
        $modelSpPenjualanBulanan = new SparepartPenjualanBulanan();

        $results = $modelSpPenjualan
            ->groupBy('id_mekanik', 'id_operator', 'id_pelanggan', 'id_sparepart', 'bulan', 'tahun')
            ->where('tanggal', '>=', $lastExtractDate)
            ->select(
                'id_mekanik',
                'id_operator',
                'id_pelanggan',
                'id_sparepart',
                DB::raw('MONTHNAME(tanggal) as bulan'),
                DB::raw('YEAR(tanggal) as tahun'),
                DB::raw('SUM(jumlah) as jumlah'),
                DB::raw('SUM(total_harga) as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return $result->getAttributes(); })->toArray();

        foreach($results as $result) {
            $modelSpPenjualanBulanan->updateOrCreate(
                [
                    'id_mekanik' => $result['id_mekanik'],
                    'id_operator' => $result['id_operator'],
                    'id_pelanggan' => $result['id_pelanggan'],
                    'id_sparepart' => $result['id_sparepart'],
                    'bulan' => $result['bulan'],
                    'tahun' => $result['tahun']
                ],
                [
                    'jumlah' => DB::raw("jumlah + {$result['jumlah']}"),
                    'total_harga' => DB::raw("total_harga + {$result['total_harga']}")
                ]
            );
        }

        return true;
    }
}
