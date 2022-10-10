const fs = require("fs");
const path = require("path");
const toTitleCase = st =>
    st.split(" ").map(c => (c.charAt(0).toUpperCase() + c.slice(1))).join(" ")

const inputPath = path.normalize("markdown/")
const outputPath = path.normalize("_posts/")
const configPath = path.normalize("config.json")
const possibleTags = JSON.parse(fs.readFileSync(configPath)).tags

const postNames = fs.readdirSync(inputPath)

fs.rmSync(outputPath, { recursive: true, force: true })
fs.mkdirSync(outputPath)

postNames.forEach(name => {
    const post = fs.readFileSync(path.normalize(inputPath + "/" + name)).toString()
    const tags = possibleTags.filter(tag => post.toLowerCase().includes(tag.toLowerCase()))

    const title = (/[^-]+-[^-]+-[^-]+-([^.]+)/).exec(name)
    const content =
        (title === null)
            ? post
            : ("---\n"
                + "title: \"" + toTitleCase(title[1].replace(/-/g, " ")) + "\"\n"
                + "tags: [" + tags + "]\n"
                + "---\n"
                + post
            )
    fs.writeFileSync(path.normalize(outputPath + "/" + name), content)
})