<?php

namespace Database\Seeders;

use App\Models\Gallery;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;


class GalleryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
		$faker = Faker::create();
		for($i=0;$i<50;$i++){
			$title = $faker->sentence(3);
			Gallery::create(array(
				'id'			=> $faker->uuid(),
				'title' 		=> $title,
				'image'       	=> $faker->imageUrl(640, 480, 'animals', true),
				'description' 	=> $faker->paragraph(1),
			));
		}
    }
}
