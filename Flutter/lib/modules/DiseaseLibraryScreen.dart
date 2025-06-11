import 'package:flutter/material.dart';
import 'DiseaseDetailScreen.dart';

class DiseaseLibraryScreen extends StatelessWidget {
  static const String id = 'DiseaseLibraryScreen';

  final List<Map<String, String>> diseases = [
    {
      'name': 'Bacterial Leaf Blight',
      "description": "Bacterial Leaf Blight is a serious disease caused by the bacterium Xanthomonas oryzae pv. oryzae. It typically starts at the tips or edges of rice leaves and causes yellowing and drying of the leaf blades, especially under humid conditions. The disease can lead to significant yield loss if not managed properly. It spreads through infected seeds, water, and contact with contaminated equipment. Preventive measures include using resistant varieties, applying proper fertilizer, and avoiding over-irrigation.",
      'image': 'https://bugwoodcloud.org/images/3072x2048/5538870.jpg'
    },
    {
      'name': 'Brown Spot',
      "description": "Brown Spot is a fungal disease caused by Bipolaris oryzae. It appears as circular to oval brown lesions on rice leaves, grains, and glumes. It thrives in nutrient-deficient soils, especially those lacking potassium and silica. The disease is most severe in drought-stressed plants. Management includes improving soil fertility, using resistant varieties, crop rotation, and fungicide application when necessary.",
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARj2_587HmoE9KYjK8YQIf6o-XOPYqMB7oA&s'
    },
    {
      'name': 'Sheath Blight',
      "description": "Sheath Blight is caused by the fungus Rhizoctonia solani. It starts as oval or irregular green-gray lesions on the leaf sheath near the waterline and can spread rapidly under high humidity. The disease causes lodging, reduced grain quality, and significant yield loss. Control methods include reducing plant density, avoiding excessive nitrogen, using resistant varieties, and applying recommended fungicides.",
      'image': 'https://gumlet.assettype.com/down-to-earth%2Fimport%2Flibrary%2Flarge%2F2019-06-13%2F0.97364800_1560433165_rice.jpg?w=480&auto=format%2Ccompress&fit=max'
    },
    {
      'name': 'Leaf Blast',
      "description": "Leaf Blast is one of the most devastating rice diseases, caused by the fungus Magnaporthe oryzae. It affects leaves, nodes, and panicles, especially during the wet season. Symptoms appear as diamond-shaped, gray-centered lesions with brown margins. The disease spreads rapidly under high humidity and temperature. Control includes using resistant varieties, balanced fertilization, proper spacing, and timely fungicide sprays.",
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKJh_jaebssDf2SQfNHA6qp6UXI619fM-YyA&s'
    },
    {
      'name': 'Leaf Scald',
      "description": "Leaf Scald is a disease caused by the bacterium Microdochium oryzae. It typically appears after flowering and is characterized by large, water-soaked lesions that rapidly turn into scalded, straw-colored streaks. These symptoms resemble heat or chemical burns. The disease reduces photosynthesis, leading to stunted growth and lower yields. Effective management includes using clean seeds, removing infected residues, and crop rotation.",
      'image': 'https://www.lsuagcenter.com/~/media/system/d/7/c/3/d7c37b4c706635ce423066827c0b872b/leafscald3.jpg?h=683&la=en&w=996'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rice Plant Diseases')),
      body: ListView.builder(
        itemCount: diseases.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final disease = diseases[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  disease['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(disease['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                disease['description']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DiseaseDetailScreen(
                      diseaseName: disease['name']!,
                      imageUrl: disease['image']!,
                      description: disease['description']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
