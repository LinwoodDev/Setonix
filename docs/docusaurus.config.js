const redirects = require('./redirects.js');

/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
    title: 'Linwood Qeck',
    tagline: 'Play games everywhere you like ',
    url: 'https://docs.qeck.linwood.dev',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/favicon.ico',
    organizationName: 'LinwoodDev', // Usually your GitHub org/user name.
    projectName: 'Qeck', // Usually your repo name.
    themeConfig: {
        colorMode: {
            defaultMode: 'dark',
            disableSwitch: false,
            respectPrefersColorScheme: true,
        },
        navbar: {
            title: 'Qeck',
            logo: {
                alt: 'Qeck Logo',
                src: 'img/logo.svg',
            },
            items: [
                {
                    type: 'doc',
                    docId: 'intro',
                    position: 'left',
                    label: 'Tutorial',
                },
                {
                    to: 'downloads',
                    label: 'Downloads',
                    position: 'left'
                },
                {
                    type: 'doc',
                    docId: 'community',
                    docsPluginId: 'community',
                    position: 'left',
                    label: 'Community',
                },
                {
                    type: 'dropdown',
                    label: 'More',
                    position: 'left',
                    items: [
                        {
                            label: 'Matrix',
                            href: 'https://linwood.dev/matrix',
                        },
                        {
                            label: 'Discord',
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'GitHub',
                            href: 'https://github.com/LinwoodDev/Qeck',
                        },
                        {
                            label: 'Blog', 
                            href: 'https://linwood.dev/blog'
                        },
                        {
                            label: 'Crowdin',
                            href: 'https://go.linwood.dev/qeck/crowdin'
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodDev',
                        },
                        {
                            label: 'License',
                            href: 'https://go.linwood.dev/qeck/license',
                        }
                    ],
                },
                {
                    type: 'docsVersionDropdown',
                    position: 'right',
                    dropdownItemsBefore: [],
                    dropdownItemsAfter: [{ to: '/versions', label: 'All versions' }],
                    dropdownActiveClassDisabled: true
                },
                {
                    type: 'localeDropdown',
                    position: 'right',
                }
            ],
        },
        footer: {
            style: 'dark',
            links: [
                {
                    title: 'Community',
                    items: [
                        {
                            label: 'Discord',
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodDev',
                        },
                        {
                            label: 'Contribution guide',
                            href: 'https://github.com/LinwoodDev/Qeck/blob/develop/CONTRIBUTING.md',
                        },
                        {
                            html: `
                <a href="https://vercel.com?utm_source=Linwood&utm_campaign=oss" target="_blank" rel="noreferrer noopener" aria-label="Deploys by Netlify">
                  <img src="/img/powered-by-vercel.svg" alt="Deploys by Netlify" />
                </a>
              `,
                        },
                    ],
                },
                {
                    title: 'Source code',
                    items: [
                        {
                            label: 'App',
                            href: 'https://github.com/LinwoodDev/Qeck/tree/develop/app',
                        },
                        {
                            label: 'Docs',
                            href: 'https://github.com/LinwoodDev/Qeck/tree/develop/docs',
                        }
                    ],
                },
                {
                    title: 'Legal',
                    items: [
                        {
                            label: 'Imprint',
                            href: 'https://go.linwood.dev/imprint',
                        },
                        {
                            label: 'Privacy Policy of the app',
                            href: '/privacypolicy',
                        },
                        {
                            label: 'Privacy Policy of the website',
                            href: 'https://go.linwood.dev/privacypolicy',
                        },
                    ],
                }
            ],
            logo: {
                alt: 'Linwood Logo',
                src: 'https://raw.githubusercontent.com/LinwoodDev/website/main/public/Linwood.png',
                width: 100,
                href: 'https://linwood.dev',
            },
            copyright: `Copyright © ${new Date().getFullYear()} LinwoodDev.`,
        },
    },
    presets: [
        [
            '@docusaurus/preset-classic',
            {
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    // Please change this to your repo.
                    editUrl:
                        'https://github.com/LinwoodDev/Qeck/edit/develop/docs/',
                },
                blog: false,
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            },
        ],
    ],
    plugins: [
        [
            '@docusaurus/plugin-content-docs',
            {
                id: 'community',
                path: 'community',
                routeBasePath: '/',
                sidebarPath: require.resolve('./sidebarsCommunity.js')
            },
        ],
        [
            '@docusaurus/plugin-client-redirects',
            {
                redirects: redirects
            },
        ],
        [
            '@docusaurus/plugin-pwa',
            {
                offlineModeActivationStrategies: [
                    'appInstalled',
                    'standalone',
                    'queryString',
                ],
                pwaHead: [
                    {
                        tagName: 'link',
                        rel: 'icon',
                        href: '/img/logo.png',
                    },
                    {
                        tagName: 'link',
                        rel: 'manifest',
                        href: '/manifest.json', // your PWA manifest
                    },
                    {
                        tagName: 'meta',
                        name: 'theme-color',
                        content: '#f2b138',
                    },
                ],
            },
        ],
        // Other tweaks
    ]
};