const fs = require("fs");
const path = require("path");
const toTitleCase = st =>
    st.split(" ").map(c => (c.charAt(0).toUpperCase() + c.slice(1))).join(" ")
const parseTitle = name => {
    const array = (/([^-]+-[^-]+-[^-]+)-([^.]+)/).exec(name)
    return (array === null)
        ? null
        : { date: array[1], title: toTitleCase(array[2].replace(/-/g, " ")) }
}

const inputPath = path.normalize("markdown/")
const outputPath = path.normalize("_posts/")
const configPath = path.normalize("config.json")
const elmFilesPath = path.normalize("_layouts/")
const generatedModule = "Generated"
const tocFileName = "Toc"
const possibleTags = JSON.parse(fs.readFileSync(configPath)).tags

const postNames = fs.readdirSync(inputPath)

fs.rmSync(outputPath, { recursive: true, force: true })
fs.mkdirSync(outputPath)

/*************************
 * create indiviual files
 * ***********************/
postNames.forEach(name => {
    const post = fs.readFileSync(path.normalize(inputPath + "/" + name)).toString()
    const tags = possibleTags.filter(tag => post.toLowerCase().includes(tag.toLowerCase()))

    const title = parseTitle(name)
    const content =
        (title === null)
            ? post
            : ("---\n"
                + "title: \"" + title.title + "\"\n"
                + "tags: [" + tags + "]\n"
                + "---\n"
                + post
            )
    fs.writeFileSync(path.normalize(outputPath + "/" + name), content)
})

/*************************
 * create table of content
 * ***********************/
const content =
    "module " + generatedModule + "." + tocFileName + " exposing (..)\n"
    + "\n"
    + "\n"
    + "posts =\n"
    + "  [ " + postNames
        .flatMap(it => {
            const title = parseTitle(it)
            return (title === null)
                ? []
                : ["{path = \"" + it + "\", title = \"" + title.title + "\"}\n"]
        })
        .join("  , ")
    + "  ]"
fs.writeFileSync(path.normalize(elmFilesPath + "/" + generatedModule + "/" + tocFileName + ".elm"), content)