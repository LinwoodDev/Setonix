import { extrudeTilesetToImage } from "tile-extruder";

const files = [
    "ground.png",
    "player.png",
    "wall.png"
];

async function main() {
    for (const file of files) {
        await extrudeTilesetToImage(16, 16, `images/${file}`, `assets/images/${file}`);
    }
}

main();