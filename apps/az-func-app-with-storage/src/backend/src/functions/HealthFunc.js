const { app } = require('@azure/functions');

app.http('HealthFunc', {
    methods: ['GET'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);

        const name = request.query.get('name') || await request.text() || 'world';

        var body = { message:`Hello, ${name}!` };

        return { jsonBody: body };
    }
});
