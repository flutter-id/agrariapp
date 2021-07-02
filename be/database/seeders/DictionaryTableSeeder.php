<?php

namespace Database\Seeders;

use App\Models\Dictionary;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class DictionaryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
		$faker = Faker::create();
		for($i=0;$i<100;$i++){
			Dictionary::create(array(
				'id'			=> $faker->uuid(),
				'term' 		    => $faker->word(),
				'description' 	=> $faker->paragraph(1),
			));
		}
    }
}
