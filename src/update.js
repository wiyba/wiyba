const path = require("path");
const fetch = require("node-fetch");
const fs = require("fs");

let stars = 0,
  page = 1;

let special;

const CountStars = async () => {
  let StarsData = await fetch(
    `https://api.github.com/users/Xenolit/starred?per_page=100&page=${page}`
  ).then((res) => res.json());
  stars += StarsData.length;
  page++;
  if (StarsData.length === 100) CountStars();
  else WriteReadMe();
};

const WriteReadMe = async () => {
  //Get ReadMe path
  const ReadMe = path.join(__dirname, "..", "README.md");
  const date = new Date();
  
  //Season Based Emoji
  let dd = date.getDate(), mm = date.getMonth() + 1
  
  if(mm === 12)special = ["⛄", "❄", "🎄"]

  //Fetching Info From Github API
  let UserData = await fetch("https://api.github.com/users/Xenolit").then(
    (res) => res.json()
  );

  //Creating the text what we gonna save on ReadMe file
  const text = `## Hi there <img src="https://raw.githubusercontent.com/Xenolit/Xenolit/main/.github/wave.gif" width="30px"> 
<img align="right" src="https://avatars.githubusercontent.com/u/76615486?v=4" width="200" />
I'm NONPLAY, An developer from somewhere in the earth. I like to code web applications and games. 
  
Thanks for visiting my github profile. Have a great day ahead!~
  
<h2 align="center"> ${special?special[0]:"✨"} About Me ${special?special[0]:"✨"}</h2>

\`\`\`js
const NONPLAY = {
    FavouriteLanguage: "Javascript/Python",
    OpenedIssues: {{ ISSUES }},
    OpenedPullRequests: {{ PULL_REQUESTS }},
    TotalCommits: {{ COMMITS }},
    Stars: ${stars},
    Repositories: {
       Created: {{ REPOSITORIES }},
       Contributed: {{ REPOSITORIES_CONTRIBUTED_TO }}
    },
}; //More statistics below ;D
\`\`\`
  
<h2 align="center"> ${special?special[1]:"🚀"} My Stats ${special?special[1]:"🚀"}</h2>
<p align="center">
<img src="https://github-readme-stats.vercel.app/api?username=Xenolit&show_icons=true&theme=radical">
</p>
<details>
  <summary>
      Even more stats
  </summary>
  <p align="center">
    <img src="https://github-readme-streak-stats.herokuapp.com/?user=Xenolit&theme=tokyonight">
    <img src="https://github-profile-trophy.vercel.app/?username=Xenolit&theme=dracula">
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=Xenolit&langs_count=8">
  </p>
</details>
  
<!-- Last updated on ${date.toString()} ;-;-->
<i>Last updated on ${date.getDate()}${
    date.getDate() === 1
      ? "st"
      : date.getDate() === 2
      ? "nd"
      : date.getDate() === 3
      ? "rd"
      : "th"
  } ${
    [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ][date.getMonth()]
  } ${date.getFullYear()} using magic</i> ${special?special[2]:"✨"}`;

  //Saving on readme.md
  fs.writeFileSync(ReadMe, text);
};

(() => {
    CountStars();
})()