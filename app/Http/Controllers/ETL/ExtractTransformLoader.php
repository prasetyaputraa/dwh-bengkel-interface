<?php

namespace App\Http\Controllers\ETL;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

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

class ExtractTransformLoader extends Controller
{
    public function loadEmployeesAll() {
        $modelEmployee    = new Employee();
        $modelEmployeeDim = new DimensionEmployee();

        $employees = $modelEmployee
            ->select(
                'id',
                'name as nama',
                'phone as no_telepon',
                'address as alamat',
                'role as jabatan'
            )
            ->get();

        $modelEmployeeDim->insert($employees->toArray());

        return true;
    }

    public function loadCustomersAll() {
        $modelCustomer    = new Customer();
        $modelCustomerDim = new DimensionCustomer();

        $customers = $modelCustomer
            ->select(
                'id',
                'name as nama',
                'phone as no_telepon',
                'address as alamat'
            )
            ->get();

        $modelCustomerDim->insert($customers->toArray());

        return true;
    }

    public function loadSparepartsAll() {
        $modelSparepart    = new Sparepart();
        $modelSparepartDim = new DimensionSparepart();

        $spareparts = $modelSparepart
            ->select(
                'id',
                'sparepart_name as nama',
                'sparepart_type as jenis_kendaraan',
                'price as harga'
            )
            ->get();

        $modelSparepartDim->insert($spareparts->toArray());

        return true;
    }

    public function loadSuppliersAll() {
        $modelSupplier    = new Supplier();
        $modelSupplierDim = new DimensionSupplier();

        $suppliers = $modelSupplier
            ->select(
                'id',
                'name as nama',
                'phone as no_telepon',
                'address as alamat'
            )
            ->get();

        $modelSupplierDim->insert($suppliers->toArray());

        return true;
    }

    public function loadServicesAll() {
        $modelService    = new Service();
        $modelServiceDim = new DimensionService();

        $services = $modelService
            ->select(
                'id',
                'service_type as nama',
                'vehicle_model as jenis_kendaraan',
                'price as harga'
            )
            ->get();

        $modelServiceDim->insert($services->toArray());

        return true;
    }
}
