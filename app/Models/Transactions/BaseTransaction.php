<?php

namespace App\Models\Transactions;

interface BaseTransaction
{
    public function extract(BaseTransaction $model);
}
