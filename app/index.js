import { extrudeTilesetToImage } from "tile-extruder";

const files = [
    "ground",
    "player",
    "wall",
    "hud"
];

async function main() {
    for (const file of files) {
        await extrudeTilesetToImage(16, 16, `images/${file}.png`, `assets/images/${file}.png`);
    }
}

main();