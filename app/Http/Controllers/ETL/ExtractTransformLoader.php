<?php

namespace App\Http\Controllers\ETL;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Carbon\Carbon;

use DB;

use App\Models\ExtractionHistory;

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
    //run only once when the dwh is empty
    //------------------------------------------------
    //yet to implement any validation to check wheter
    //the dwh is alredy filled with data or not
    public function loadDimensionsAll() {
        $currentDateTime = Carbon::now();

        DB::beginTransaction();

        try {
            $this->loadEmployeesAll();
            $this->loadCustomersAll();
            $this->loadSparepartsAll();
            $this->loadSuppliersAll();
            $this->loadServicesAll();

            DB::commit();
        } catch (\Exception $e) {
            DB::rollback();
        }

        $modelExtractionHist = new ExtractionHistory();

        $modelExtractionHist->newRecord($currentDateTime->toDateTimeString());

        return true;
    }

    public function getNewRecordsOnDimensionsAll() {
        $modelEmployee    = new Employee();
        $modelEmployeeDim = new DimensionEmployee();

        $modelCustomer    = new Customer();
        $modelCustomerDim = new DimensionCustomer();

        $modelSparepart    = new Sparepart();
        $modelSparepartDim = new DimensionSparepart();

        $modelSupplier    = new Supplier();
        $modelSupplierDim = new DimensionSupplier();

        $modelService    = new Service();
        $modelServiceDim = new DimensionService();

        $employees  = $modelEmployee->extract($modelEmployee->afterLastExtract('Dimensions'))->get()->toArray();
        $customers  = $modelCustomer->extract($modelCustomer->afterLastExtract('Dimensions'))->get()->toArray();
        $spareparts = $modelSparepart->extract($modelSparepart->afterLastExtract('Dimensions'))->get()->toArray();
        $suppliers  = $modelSupplier->extract($modelSupplier->afterLastExtract('Dimensions'))->get()->toArray();
        $services   = $modelService->extract($modelService->afterLastExtract('Dimensions'))->get()->toArray();

        $currentDateTime = Carbon::now();

        if (
            empty($employees) 
            && empty($cutomers) 
            && empty($spareparts) 
            && empty($suppliers) 
            && empty($services)
        ) {
            return false;
        }

        DB::beginTransaction();

        try {
            $modelEmployeeDim->insert($employees);
            $modelCustomerDim->insert($customers);
            $modelSparepartDim->insert($spareparts);
            $modelSupplierDim->insert($suppliers);
            $modelServiceDim->insert($services);

            $modelExtractionHist = new ExtractionHistory();

            $modelExtractionHist->newRecord($currentDateTime->toDateTimeString(), 'Dimensions');

            DB::commit();
        } catch (\Exception $e) {
            DB::rollback();

            return $e->getMessage();
        }

        return true;
    }

    public function loadEmployeesAll() {
        $modelEmployee    = new Employee();
        $modelEmployeeDim = new DimensionEmployee();

        $employees = $modelEmployee->extract($modelEmployee)->get();

        $modelEmployeeDim->insert($employees->toArray());

        return true;
    }

    public function loadCustomersAll() {
        $modelCustomer    = new Customer();
        $modelCustomerDim = new DimensionCustomer();

        $customers = $modelCustomer->extract($modelCustomer)->get();

        $modelCustomerDim->insert($customers->toArray());

        return true;
    }

    public function loadSparepartsAll() {
        $modelSparepart    = new Sparepart();
        $modelSparepartDim = new DimensionSparepart();

        $spareparts = $modelSparepart->extract($modelSparepart)->get();

        $modelSparepartDim->insert($spareparts->toArray());

        return true;
    }

    public function loadSuppliersAll() {
        $modelSupplier    = new Supplier();
        $modelSupplierDim = new DimensionSupplier();

        $suppliers = $modelSupplier->extract($modelSupplier)->get();

        $modelSupplierDim->insert($suppliers->toArray());

        return true;
    }

    public function loadServicesAll() {
        $modelService    = new Service();
        $modelServiceDim = new DimensionService();

        $services = $modelService->extract($modelService)->get();

        $modelServiceDim->insert($services->toArray());

        return true;
    }
}
